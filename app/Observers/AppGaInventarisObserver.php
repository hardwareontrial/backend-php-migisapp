<?php

namespace App\Observers;

use App\Models\API\GaInventaris\AppGaInventaris;
use App\Models\API\GaInventaris\AppGaInventarisLog;
use Illuminate\Support\Facades\DB;

class AppGaInventarisObserver
{
    protected $except = [
        'created_at',
        'updated_at',
        'deleted_at',
        'id',
        'kd_brg',
        'pemilik_id',
        'qrcode',
        'dept_user'
    ];

    /**
     * Handle the AppGaInventaris "created" event.
     *
     * @param  \App\Models\API\GaInventaris\AppGaInventaris  $appGaInventaris
     * @return void
     */
    public function created(AppGaInventaris $appGaInventaris)
    {
        DB::beginTransaction();
        $log = new AppGaInventarisLog();
        $log->gainventaris_id = $appGaInventaris->id;
        $log->created_by = auth('sanctum')->user()->detailuser->id;
        $log->action = 1;
        foreach($appGaInventaris->fresh()->getOriginal() as $key => $val){
            if(!in_array($key, $this->except)){
                $nkey = 'n_'.$key;
                $log->$nkey = $val;
            }
        }
        $log->save();
        DB::commit();
    }

    /**
     * Handle the AppGaInventaris "updated" event.
     *
     * @param  \App\Models\API\GaInventaris\AppGaInventaris  $appGaInventaris
     * @return void
     */
    public function updated(AppGaInventaris $appGaInventaris)
    {
        DB::beginTransaction();
        $log = new AppGaInventarisLog();
        $log->gainventaris_id = $appGaInventaris->id;
        $log->created_by = auth('sanctum')->user()->detailuser->id;
        $log->action = 2;
            foreach($appGaInventaris->getAttributes() as $key => $nVal){
                if(!in_array($key, $this->except)){
                    $oVal = $appGaInventaris->getOriginal($key);
                    $oKey = 'o_'.$key;
                    $nKey = 'n_'.$key;
                    $log->$oKey = $oVal;
                    $log->$nKey = $nVal;
                }
            }
        $log->save();
        DB::commit();
    }

    /**
     * Handle the AppGaInventaris "deleted" event.
     *
     * @param  \App\Models\API\GaInventaris\AppGaInventaris  $appGaInventaris
     * @return void
     */
    public function deleted(AppGaInventaris $appGaInventaris)
    {
        //
    }

    /**
     * Handle the AppGaInventaris "restored" event.
     *
     * @param  \App\Models\API\GaInventaris\AppGaInventaris  $appGaInventaris
     * @return void
     */
    public function restored(AppGaInventaris $appGaInventaris)
    {
        //
    }

    /**
     * Handle the AppGaInventaris "force deleted" event.
     *
     * @param  \App\Models\API\GaInventaris\AppGaInventaris  $appGaInventaris
     * @return void
     */
    public function forceDeleted(AppGaInventaris $appGaInventaris)
    {
        //
    }
}
