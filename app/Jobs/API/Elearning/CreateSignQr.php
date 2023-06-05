<?php

namespace App\Jobs\API\Elearning;

use App\Models\API\Elearning\AppElearningCertificate;
use App\Models\API\Elearning\AppElearningSchedule;
use App\Models\API\User\AppUser;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\File;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class CreateSignQr implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $quizid;
    protected $signerid;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($quizid, $signerid)
    {
      $this->quizid = $quizid;
      $this->signerid = $signerid;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
      /** store path */
      $date = Carbon::now()->format('Ymd');
      $quizid = $this->quizid;
      $signerid = $this->signerid;

      $storepath = storage_path('app/public/app_elearning/quiz/').$date.'_'.$quizid;
      if(!File::exists($storepath)){
        File::makeDirectory($storepath, 0777, true);
      }

      /** get top sign */
      $signer = AppUser::where('id', $signerid)->with('position')->first();
      $signer_name = $signer->name;
      $signerpos = $signer->position ? $signer->position->name : null;
      
      $logsCert = AppElearningCertificate::create([
        'schedule_id' => $quizid,
        'signer_name' => $signer_name,
        'signer_position' => $signerpos,
        'folder_name' => $date.'_'.$quizid,
      ]);

      $updateQuiz = AppElearningSchedule::find($this->quizid);
      $updateQuiz->certificate_id = $logsCert->id;
      $updateQuiz->save();

      /** store and generate qr */
      $qr_content = "SERTIFIKASI INI DIADAKAN OLEH MOLINDO INTI GAS\n\nSERTIFIKAT DIKELUARKAN DAN DISETUJUI OLEH\n".$signer_name."\n".$signerpos;
      $qr_filename = 'qr_sign.png';
      QrCode::size(700)
        ->format('png')
        ->style('round')
        ->gradient(245, 159, 33, 47, 56, 126, 'diagonal')
        ->generate($qr_content, $storepath.'/'.$qr_filename);
    }
}
