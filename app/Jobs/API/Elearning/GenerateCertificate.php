<?php

namespace App\Jobs\API\Elearning;

use App\Models\API\Elearning\AppElearningUserdataExam;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Intervention\Image\Facades\Image;

class GenerateCertificate implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $id;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($id)
    {
        $this->id = $id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $userexam_data_id = $this->id;
        $data = AppElearningUserdataExam::where('id',$userexam_data_id)->with('schedule', 'datauser')->first();

        /** check if exam has certificate */
        $hasCertificate = $data->schedule->certificate_id;
        if($hasCertificate !== 0){

            $exam_finish_date = Carbon::parse($data->updated_at)->translatedFormat('d M Y');
            $img = Image::make(storage_path('app/public/app_elearning/quiz/base_certificate/base_v1.png'));

            /** storage_path */
            $data_filepath = $data->schedule->certificate_data->folder_name;
            $certificate_filename = $data_filepath.'_'.$data->user_nik.'.png';

            /** Modify name */
            $raw_name = strtoupper(trim($data->datauser->name));
            $name_length = strlen($raw_name);
            $firstletters = [];

            if($name_length >= 25) {
                $raw_name_words = explode(' ', $raw_name);
                foreach ($raw_name_words as $raw_name_word) {
                $letter = mb_substr($raw_name_word, 0, 1);
                array_push($firstletters, $letter);
                }
                // pick first & middle name
                $slice_1 = array_slice($raw_name_words, 0, 2);
                $raw_name_1 = implode(' ', $slice_1);
        
                // pick last name & others
                $slice_2 = array_slice($firstletters, 2);
                $raw_name_2 = implode('. ',$slice_2);
                $final_name = $raw_name_1.' '.$raw_name_2;
            }else{
                $final_name = $raw_name;
            }

            /** Wrap Exam Text */
            $raw_exam_title = strtoupper($data->schedule->title);
            $wrapped_exam_title = wordwrap($raw_exam_title, 30, '\n');
            $exam_words = explode('\n', $wrapped_exam_title);
            
            /** insert qrcode */
            $img->insert(storage_path('app/public/app_elearning/quiz/'.$data_filepath.'/qr_sign.png'), 'bottom-center', 300, 300);

            /** insert participant name */
            $img->text($final_name, 3508, 2431, function($font){
                $font->file(storage_path('app/public/app_elearning/quiz/base_certificate/WixMadeforDisplay-Bold.ttf'));
                $font->color('#2D3A7A');
                $font->size(240);
                $font->align('center');
                $font->valign('middle');
            });

            /** insert sub-title */
            $img->text('For successfully completing the:', 3508, 2981, function($font){
                $font->file(storage_path('app/public/app_elearning/quiz/base_certificate/WixMadeforDisplay-Regular.ttf'));
                $font->color('#C2C0C0');
                $font->size(120);
                $font->align('center');
                $font->valign('middle');
            });

            /** insert exam title */
            for ($i = 0; $i < count($exam_words); $i++) {
                $position = 3251 + ($i * 150);
                $img->text($exam_words[$i], 3508, $position, function($font){
                    $font->file(storage_path('app/public/app_elearning/quiz/base_certificate/WixMadeforDisplay-SemiBold.ttf'));
                    $font->color('#2D3A7A');
                    $font->size(144);
                    $font->align('center');
                    $font->valign('middle');
                });
            }

            /** insert date */
            $img->text($exam_finish_date, 3508, 4830, function($font){
                $font->file(storage_path('app/public/app_elearning/quiz/base_certificate/WixMadeforDisplay-Bold.ttf'));
                $font->color('#2D3A7A');
                $font->size(64);
                $font->align('center');
                $font->valign('middle');
            });

            $img->save(storage_path('app/public/app_elearning/quiz/'.$data_filepath.'/'.$certificate_filename));

            $data->certificate = $data_filepath.'/'.$certificate_filename;
            $data->save();
        }
    }
}
