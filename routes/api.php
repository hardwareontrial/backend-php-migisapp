<?php

use App\Http\Controllers\API\Auth\AppUserLoginController;
use App\Http\Controllers\API\DeliveryNote\AppSuratJalanController;
use App\Http\Controllers\API\DeliveryNote\AppSuratJalanExportController;
use App\Http\Controllers\API\Elearning\ElearningMaterialController;
use App\Http\Controllers\API\Elearning\ElearningQuestionController;
use App\Http\Controllers\API\Elearning\ElearningScheduleController;
use App\Http\Controllers\API\Elearning\ElearningUserdataExamController;
use App\Http\Controllers\API\GaInventaris\AppGaInventarisController;
use App\Http\Controllers\API\GaInventaris\AppGaInventarisExportController;
use App\Http\Controllers\API\Hr\AppAttendanceController;
use App\Http\Controllers\API\Hr\AppDepartmenController;
use App\Http\Controllers\API\Hr\AppPositionController;
use App\Http\Controllers\API\Misc\ListController;
use App\Http\Controllers\API\Phonebook\PhonebookExternalController;
use App\Http\Controllers\API\SimpleTodo\AppSimpleTodoController;
use App\Http\Controllers\API\User\AppUserController;
use App\Http\Controllers\API\User\Permission\AppPermissionController;
use Illuminate\Support\Facades\Route;

/** User Route */
Route::group(['prefix' => 'user', 'middleware' => 'auth:sanctum'], function(){
  Route::get('all', [AppUserController::class, 'index']);
  Route::get('{nik}', [AppUserController::class, 'detail']);
  Route::post('store', [AppUserController::class, 'store']);
  Route::post('update/{id}', [AppUserController::class, 'update']);
  Route::patch('setactive/{id}', [AppUserController::class, 'changeactive']);
  Route::group(['prefix' => 'new'], function(){
    Route::get('number', [AppUserController::class, 'providenik']);
  });
  Route::group(['prefix' => 'permission'], function(){
    Route::get('data', [AppPermissionController::class, 'index']);
    Route::put('update/{nik}', [AppPermissionController::class, 'update']);
  });
  Route::group(['prefix' => 'auth'], function(){
    Route::post('register', [AppUserLoginController::class, 'register']);
    Route::post('login', [AppUserLoginController::class, 'login'])->withoutMiddleware('auth:sanctum');
    Route::post('logout', [AppUserLoginController::class, 'logout']);
    Route::group(['prefix' => 'update'], function(){
      Route::post('password/{nik}', [AppUserLoginController::class, 'changepassword']);
      Route::patch('active/{nik}', [AppUserLoginController::class, 'changeactive']);
      Route::put('{nik}', [AppUserLoginController::class, 'update']);
    });
  });
});

/** Delivery Letter Route */
Route::group(['prefix' => 'deliverynote', 'middleware' => 'auth:sanctum'], function(){
  Route::get('data', [AppSuratJalanController::class, 'index']);
  Route::get('data/{deliveryno}', [AppSuratJalanController::class, 'detail']);
  Route::get('export', [AppSuratJalanController::class, 'export']);
  Route::get('export', [AppSuratJalanExportController::class, 'export']);
  Route::post('new', [AppSuratJalanController::class, 'store']);
  Route::post('data/{deliveryno}', [AppSuratJalanController::class, 'update']);
});

/** Phonebook Route */
Route::group(['prefix' => 'phonebook', 'middleware' => 'auth:sanctum'], function(){
  Route::group(['prefix' => 'external'], function(){
    Route::get('data', [PhonebookExternalController::class, 'index']);
    Route::get('data/{id}', [PhonebookExternalController::class, 'detail']);
    Route::post('new', [PhonebookExternalController::class, 'store']);
    Route::put('data/{id}', [PhonebookExternalController::class, 'update']);
    Route::delete('data/{id}', [PhonebookExternalController::class, 'delete']);
    Route::delete('data/{id}/detail/{iddetail}', [PhonebookExternalController::class, 'deletedetail']);
  });
  Route::group(['prefix' => 'internal'], function(){
    //
  });
});

/** GA-Inventaris Route */
Route::group(['prefix' => 'inventaris', 'middleware' => 'auth:sanctum'], function(){
  Route::group(['prefix' => 'export'], function(){
    Route::get('byuser', [AppGaInventarisExportController::class, 'exportbyuser']);
    Route::get('bylocation', [AppGaInventarisExportController::class, 'exportbylocation']);
  });
  Route::get('user', [AppGaInventarisController::class, 'detailbyuser']);
  Route::get('data', [AppGaInventarisController::class, 'index']);
  Route::get('data/{id}', [AppGaInventarisController::class, 'detail'])->withoutMiddleware('auth:sanctum');
  Route::post('new', [AppGaInventarisController::class, 'store']);
  Route::post('new-merk', [AppGaInventarisController::class, 'addmerk']);
  Route::post('new-location', [AppGaInventarisController::class, 'addlocation']);
  Route::put('data/{code}', [AppGaInventarisController::class, 'update']);
  Route::delete('sell/{id}', [AppGaInventarisController::class, 'delete']);
});

/** Simple-Todo Route */
Route::group(['prefix' => 'todo', 'middleware' => 'auth:sanctum'], function(){
  Route::get('data', [AppSimpleTodoController::class, 'index']);
  Route::post('data', [AppSimpleTodoController::class, 'store']);
  Route::put('data/{id}', [AppSimpleTodoController::class, 'update']);
  Route::patch('completed/{id}', [AppSimpleTodoController::class, 'markcomplete']);
  Route::patch('deleted/{id}', [AppSimpleTodoController::class, 'markdelete']);
});

/** HR Route */
Route::group(['prefix' => 'hr', 'middleware' => 'auth:sanctum'], function(){
  Route::group(['prefix' => 'attendace'], function(){
    Route::get('sync-data', [AppAttendanceController::class, 'index']);
    Route::get('sync', [AppAttendanceController::class, 'sync']);
    Route::get('generate-data', [AppAttendanceController::class, 'generateText']);
    Route::get('scan-new-pegawai', [AppAttendanceController::class, 'scanNewPegawai']);
    Route::get('sync-auto', [AppAttendanceController::class, 'autosync']);
    Route::get('generate-auto', [AppAttendanceController::class, 'generateAutoText']);
  });
  Route::group(['prefix' => 'department'], function(){
    Route::get('data', [AppDepartmenController::class, 'index']);
    Route::post('new', [AppDepartmenController::class, 'store']);
    Route::post('data/{id}', [AppDepartmenController::class, 'update']);
  });
  Route::group(['prefix' => 'position'], function(){
    Route::get('data', [AppPositionController::class, 'index']);
    Route::post('data/{id}', [AppPositionController::class, 'update']);
  });
});

/** Elearning */
Route::group(['prefix' => 'okm', 'middleware' => 'auth:sanctum'], function(){
  Route::group(['prefix' => 'schedule'], function(){
    Route::get('handlelist', [ElearningScheduleController::class, 'listparticipant']);
    Route::get('data', [ElearningScheduleController::class, 'schedulelist']);
    Route::get('detail/{id}', [ElearningScheduleController::class, 'detailschedule']);
    Route::post('new', [ElearningScheduleController::class, 'storeschedule']);
    Route::post('setactive/{id}', [ElearningScheduleController::class, 'setactive']);
    Route::delete('{id}', [ElearningScheduleController::class, 'deleteschedule']);
    Route::group(['prefix' => 'participant'], function(){
      Route::post('{id}', [ElearningScheduleController::class, 'updateexamparticipant']);
      Route::delete('{id}', [ElearningScheduleController::class, 'deleteparticipant']);
    });
  });
  Route::group(['prefix' => 'material'], function(){
    Route::get('deptlist', [ElearningMaterialController::class, 'handleListDept']);
    Route::get('list', [ElearningMaterialController::class, 'handleList']);
    Route::get('all', [ElearningMaterialController::class, 'materialall']);
    Route::get('{id}', [ElearningMaterialController::class, 'detailmaterial']);
    Route::post('new', [ElearningMaterialController::class, 'storematerial']);
    Route::put('{id}', [ElearningMaterialController::class, 'updatematerial']);
    Route::delete('{id}', [ElearningMaterialController::class, 'deletematerial']);
    Route::group(['prefix' => 'file'], function(){
      Route::post('{id}', [ElearningMaterialController::class, 'addfilematerial']);
      Route::delete('{id}', [ElearningMaterialController::class, 'deletefilematerial']);
    });
  });
  Route::group(['prefix' => 'question'], function(){
    Route::post('new', [ElearningQuestionController::class, 'storequestion']);
    Route::get('all', [ElearningQuestionController::class, 'dataquestion']);
    Route::get('detail/{id}', [ElearningQuestionController::class, 'detailquestion']);
    Route::put('{id}', [ElearningQuestionController::class, 'updatedetailquestion']);
    Route::delete('{id}', [ElearningQuestionController::class, 'deletequestion']);
    Route::put('setcative/{id}', [ElearningQuestionController::class, 'setactive']);
    Route::get('list', [ElearningQuestionController::class, 'questionlist']);
    Route::group(['prefix' => 'collection'], function(){
      Route::get('{id}', [ElearningQuestionController::class, 'detailQuestionCollection']);
      Route::get('{id}/status', [ElearningQuestionController::class, 'statusQuestionCollection']);
      Route::post('{id}', [ElearningQuestionController::class, 'updateQuestionCollection']);
      Route::delete('{id}', [ElearningQuestionController::class, 'deleteQuestionCollection']);
      Route::post('{id}/addfromfile', [ElearningQuestionController::class ,'addQuesitionCollectionUploadFile']);
    });
  });
  Route::group(['prefix' => 'userexam'], function(){
    Route::get('all', [ElearningUserdataExamController::class, 'index']);
  });
});

/** Miscellaneous Route */
Route::group(['prefix' => 'misc', 'middleware' => 'auth:sanctum'], function(){
  Route::group(['prefix' => 'list'], function(){
    Route::get('usernologin', [ListController::class, 'userWithoutLogin']);
    Route::get('depts', [ListController::class, 'departments']);
    Route::get('positions', [ListController::class, 'positions']);
    Route::get('userlist', [ListController::class, 'userlist']);
    Route::get('merk', [ListController::class, 'listmerk']);
    Route::get('location', [ListController::class, 'listlocation']);
    Route::get('gainventaris', [ListController::class, 'gainventaris']);
  });
});
