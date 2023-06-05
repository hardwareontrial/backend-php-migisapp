<?php

function transformRoleToSubject($user)
{
  $permissions = $user->getAllPermissions()->pluck('name');
  foreach($permissions as $permission){
    $p = explode('.', $permission);
    $obj = (object)['action' => $p[0], 'subject' => $p[1]];
    $parray[] = $obj;
  }
  return $parray;
  // dd($permissions);
}
