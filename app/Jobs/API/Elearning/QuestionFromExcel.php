<?php

namespace App\Jobs\API\Elearning;

use App\Models\API\Elearning\AppElearningQuestion;
use App\Models\API\Elearning\AppElearningQuestionCollection;
use App\Models\API\Elearning\AppElearningQuestionStatusUpload;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
use PhpOffice\PhpSpreadsheet\Worksheet\MemoryDrawing;
use Illuminate\Support\Facades\File;
use stdClass;

class QuestionFromExcel implements ShouldQueue
{
  use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

  protected $filename; 
  protected $materialid; 
  protected $newid;
  protected $statusid;

  /**
   * Create a new job instance.
   *
   * @return void
   */
  public function __construct($filename, $materialid, $newid, $statusid)
  {
    $this->filename = $filename; 
    $this->materialid = $materialid; 
    $this->newid = $newid;
    $this->statusid = $statusid;
  }

  /**
   * Execute the job.
   *
   * @return void
   */
  public function handle()
  {
    $filename = $this->filename; 
    $materialid = $this->materialid; 
    $newid = $this->newid;
    $statusid = $this->statusid;

    $reader = new Xlsx();
    $spreadsheet = $reader->load(storage_path('app/public/app_elearning/soal/s-').$newid.'/'.$filename);
    $sheet = $spreadsheet->getActiveSheet();
    $row_limit = $sheet->getHighestDataRow();
    $update = AppElearningQuestionStatusUpload::find($statusid);
    $initializeform = $sheet->getCell('A1')->getValue();
    if($initializeform != 'Form_by_IT'){
      $update->update([
        'status' => 3
      ]);
      unlink(storage_path('app/public/app_elearning/soal/s-').$newid.'/'.$filename);
    }else{
      $startrow = 9;
      if($startrow > $row_limit){
        $update->update([
          'status' => 3
        ]);
        unlink(storage_path('app/public/app_elearning/soal/s-').$newid.'/'.$filename);
      }else{
        $row_range = range($startrow, $row_limit);

        /** Extract Image */
        $rawdrawings = $sheet->getDrawingCollection();
        $arrayimages = array();
        foreach($rawdrawings as $rawdrawing){
          if($rawdrawing->getPath()){
            $zipReader = fopen($rawdrawing->getPath(),'r');
            $imageContents = '';
            while (!feof($zipReader)) {
              $imageContents .= fread($zipReader,1024);
            }
            fclose($zipReader);
            $extension = $rawdrawing->getExtension();
            $base64 = 'data:image/' . $extension . ';base64,' . base64_encode($imageContents);
            $object = new stdClass();
            $object->base64 = $base64;
            $object->coordinate = $rawdrawing->getCoordinates();
            array_push($arrayimages, $object);
          }
        }

        /** Set format pereach row */
        $datafromexcel = array();
        
        foreach($row_range as $row){
          $ab = new stdClass();
          $answerOptions = array();
          $answerkey = null;

          /** Question (Row BC) */
            $eachQuestion = new stdClass();
            $imgqst = $this->checkarrayimage($arrayimages, $row, 'C');
            $eqtext = $sheet->getCell( 'B'. $row)->getValue();
            if($eqtext || $imgqst){
              $eachQuestion->text = $eqtext;
              $eachQuestion->image = $imgqst;
            }

          /** Answer Opts (Row D-K) */
            $answopt_1 = new stdClass();
            $imgqst1 = $this->checkarrayimage($arrayimages, $row, 'E');
            $eqtext1 = $sheet->getCell( 'D'. $row)->getValue();
            if($eqtext1 || $imgqst1){
              $answopt_1->image = $imgqst1;
              $answopt_1->text = $eqtext1;
              $answopt_1->value = 1;
              array_push($answerOptions, $answopt_1);
            }

            $answopt_2 = new stdClass();
            $imgqst2 = $this->checkarrayimage($arrayimages, $row, 'G');
            $eqtext2 = $sheet->getCell( 'F'. $row)->getValue();
            if($eqtext2 || $imgqst2){
              $answopt_2->image = $imgqst2;
              $answopt_2->text = $eqtext2;
              $answopt_2->value = 2;
              array_push($answerOptions, $answopt_2);
            }
            
            $answopt_3 = new stdClass();
            $imgqst3 = $this->checkarrayimage($arrayimages, $row, 'I');
            $eqtext3 = $sheet->getCell( 'H'. $row)->getValue();
            if($eqtext3 || $imgqst3){
              $answopt_3->text = $eqtext3;
              $answopt_3->image = $imgqst3;
              $answopt_3->value = 3;
              array_push($answerOptions, $answopt_3);
            }
            
            $answopt_4 = new stdClass();
            $imgqst4 = $this->checkarrayimage($arrayimages, $row, 'K');
            $eqtext4 = $sheet->getCell( 'J'. $row)->getValue();
            if($eqtext4 || $imgqst4){
              $answopt_4->text = $eqtext4;
              $answopt_4->image = $imgqst4;
              $answopt_4->value = 4;
              array_push($answerOptions, $answopt_4);
            }
          
          /** AnswerKey (Row L) */
            $answerkey = $sheet->getCell( 'L'. $row)->getValue();
          
          $ab->question = $eachQuestion;
          $ab->answer_options = $answerOptions;
          $ab->answer_key = $answerkey;
          array_push($datafromexcel, $ab);
        }
        foreach($datafromexcel as $question){
          if($question->question->text || $question->question->image){
            DB::transaction(function() use ($question, $filename, $newid, $update){
              $storeqst = AppElearningQuestionCollection::create([
                'questions_id' => $newid,
                'question' => $question->question,
                'answer_options' => $question->answer_options,
                'answer_key' => $question->answer_key,
                'sourcefile' => $filename,
              ]);
              if($storeqst){ $update->update([ 'status' => 2 ]);
              }else{ 
                $update->update([ 'status' => 3 ]);
              }
            });
          }
        }
      }
    }
  }

  private function checkarrayimage($array, $row, $cell)
  {
    foreach($array as $a){
      if($a->coordinate === $cell.$row){
        return $a->base64;
      }
    }
    return null;
  }
}