<?php

namespace App\Http\Controllers\API\Elearning;

use App\Http\Controllers\Controller;
use App\Models\API\Elearning\AppElearningQuestionCollection;
use App\Models\API\Elearning\AppElearningUserdataExam;
use Illuminate\Http\Request;

class ElearningUserdataExamController extends Controller
{
  /**
  * Display a listing of the resource.
  *
  * @return \Illuminate\Http\Response
  */
  public function index()
  {
    $tmp = AppElearningUserdataExam::where('user_nik', request()->userdataNik)->orderBy('id', 'desc')->with('schedule.dataquestion.questions')->get();
    foreach ($tmp as $px){
      $shuffled_id = $px->questions_pattern;
      $dataquestions = AppElearningQuestionCollection::whereIn('id', $shuffled_id)->get();
      $reorder = collect([]);

      $reorder2 = [];
      if($px->answers_user){ $cansuser = count($px->answers_user); }else{ $cansuser = 0; }
      if($cansuser > 0){
        foreach($px->answers_user as $au){
          $idau = $au['id'];
          $valau = $au['value'];
          $dq = AppElearningQuestionCollection::find($idau);
          $au['questions_id'] = $dq->questions_id;
          $au['question'] = $dq->question;
          $au['answer_options'] = $dq->answer_options;
          $au['answer_key'] = $dq->answer_key;
          // $reorder2->push($au);
          array_push($reorder2, $au);
        }
        unset($px->answers_user);
        $px->answers_user = $reorder2;
      }else{
        unset($px->answers_user);
        $px->answers_user = [];
      }
      foreach ($shuffled_id as $id){
        $tmpqst = $dataquestions->where('id', $id)->first();
        $tmpao = $tmpqst->answer_options;
        $sfansopt = collect($tmpao)->shuffle();
        unset($tmpqst->answer_options);
        $tmpqst->answer_options = $sfansopt;
        $reorder->push($tmpqst);
      }
      $px->qstpattern = $reorder;
      unset($px->questions_pattern);
    }
    return $tmp;
  }

  /**
  * Show the form for creating a new resource.
  *
  * @return \Illuminate\Http\Response
  */
  public function create()
  {
    //
  }

  /**
   * Store a newly created resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @return \Illuminate\Http\Response
   */
  public function store(Request $request)
  {
    //
  }

  /**
   * Display the specified resource.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
  */
  public function show($id)
  {
    //
  }

  /**
   * Show the form for editing the specified resource.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function edit($id)
  {
    //
  }

  /**
   * Update the specified resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function update(Request $request, $id)
  {
    //
  }

  /**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function destroy($id)
  {
    //
  }
}
