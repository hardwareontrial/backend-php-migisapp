<?php

namespace App\Imports\API\AppElearning;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;

class QuestionImport implements ToCollection
{
  /**
  * @param Collection $collection
  */
  public function collection(Collection $collection)
  {
    dd($collection);
  }
}
