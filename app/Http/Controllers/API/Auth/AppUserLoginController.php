<?php

namespace App\Http\Controllers\API\Auth;

use App\Http\Controllers\Controller;
use App\Models\API\Auth\AppUserLogin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AppUserLoginController extends Controller
{
  public function register(Request $request)
  {
    $shortnik = substr($request->input('nik'), -3);
    $login = AppUserLogin::create([
      'nik' => $request->input('nik'),
      's_nik' => $shortnik,
      'email' => $request->input('email'),
      'password' => Hash::make($request->input('new_password')),
      'active' => $request->input('loginActive'),
      'admin' => 0
    ]);

    if(!$login){ return response()->json(['message' => 'Data gagal disimpan'], 500); }
    $user = AppUserLogin::where('nik', $request->input('nik'))->first();
    $user->syncPermissions(["read.Auth", "read.ACL"]);
    return response()->json(['message' => 'Data berhasil disimpan'], 200);
  }

  public function login(Request $request)
  {
    $username = $request->input('username');
    $password = $request->input('password');

    $user = AppUserLogin::where(function ($query) use ($username){ $query
      ->where('email', 'LIKE', $username)
      ->orWhere('nik', 'LIKE', $username)
      ->orWhere('s_nik', 'LIKE', $username);
    })
    ->with('detailuser.position.deptname', 'detailuser.position.parent.user', 'detailuser.position.children.user')
    ->first();
    if(!$user) { return response()->json(['message' => 'User tidak ditemukan'], 404); }
    if($user->active !== 1) { return response()->json(['message' => 'User tidak aktif'], 400); }
    if($user->detailuser->active !== 1) { return response()->json(['message' => 'User tidak ditemukan'], 404); }
    if(!Hash::check($password, $user->password)) { return response()->json(['message' => 'Username/Password tidak sesuai'], 400); }

    $token = $user->createToken($user->nik)->plainTextToken;
    $user['ability'] = transformRoleToSubject($user);

    return response()->json([
      'message' => 'Login berhasil',
      'token' => $token,
      'userdata' => $user],
    200);
  }

  public function logout(Request $request)
  {
    $logout = $request->user()->currentAccessToken()->delete();
    if(!$logout) { return response()->json(['message' => 'SignOut Gagal.'], 500); }
    return response()->json(['message' => 'Logout berhasil.'], 200);
  }

  public function changepassword(Request $request, $nik)
  {
    $frompage = request()->frompage;
    if($frompage === 'usersettings-resetpassword'){
      $user = AppUserLogin::where('nik', $nik)->first();
      if($request->valueRePassword !== $request->valuePasswordNew){ return response()->json(['message' => 'Password Baru tidak sesuai'], 500); }
      if(!Hash::check($request->valuePasswordOld, $user->password)){ return response()->json(['message' => 'Password tidak sesuai'], 500); }
      $newpassword = Hash::make($request->valuePasswordNew);
      $user->password = $newpassword;
      $user->save();
      return response()->json(['message' => 'success'], 200);
    }
    else if($frompage === 'usermgt-resetpassword'){
      $user = AppUserLogin::where('nik', $nik)->first();
      $password = $request->resetpassword;
      $resetpassword = Hash::make($password);
      $user->password = $resetpassword;
      $user->save();
      if (!$user) {
        return response()->json(['message' => 'Reset password gagal.'], 500);
      }
      return response()->json(['message' => 'Password berhasil direset, password baru: ' . $password . '.'], 200);
    }
  }

  public function changeactive(Request $request, $nik)
  {
    $data2 = AppUserLogin::findOrFail($nik);
    $data2->active = $request->input('newvalue');
    $data2->save();
    return response()->json(['message' => 'Data berhasil diupdate.'], 200);
  }

  public function update(Request $request, $nik)
  {
    $data = AppUserLogin::findOrFail($nik);
    $data->update([
      'email' => $request->input('email'),
      'active' => $request->input('loginActive'),
    ]);
    return response()->json(['Data berhasi diupdate'], 200);
  }
}
