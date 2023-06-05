<?php

namespace App\Exports\API\SuratJalan;

use App\Models\API\DeliveryNote\AppSuratJalan;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class ByDefault implements WithMapping, WithHeadings, FromQuery, ShouldAutoSize
{
  public function __construct($creatorid, $createstartdate, $createenddate, $sentstartdate, $sentenddate)
  {
    $this->creatorid = $creatorid;
    $this->createstartdate = $createstartdate; 
    $this->createenddate = $createenddate; 
    $this->sentstartdate = $sentstartdate; 
    $this->sentenddate = $sentenddate;
  }

  public function query()
  {
    $creatorid = $this->creatorid;
    $createstartdate = $this->createstartdate; 
    $createenddate = $this->createenddate;
    $sentstartdate = $this->sentstartdate; 
    $sentenddate = $this->sentenddate;

    return AppSuratJalan::where(function ($query) use ($creatorid, $createstartdate, $createenddate, $sentstartdate, $sentenddate){ $query
      ->where(function ($query) use ($creatorid){ 
        if(count($creatorid) != 0) { $query->whereIn('created_by', $creatorid); }else{ $query->whereNotNull('created_by'); }
      })
      ->whereHas('detail', function ($query) use ($createstartdate, $createenddate, $sentstartdate, $sentenddate){ $query
        ->whereBetween('created_at', [$createstartdate, $createenddate])
        ->where(function ($query) use ($sentstartdate, $sentenddate){ if ($sentstartdate != '' && $sentenddate != '') { $query
          ->whereBetween('detail_sending_date', [$sentstartdate, $sentenddate]); };
        });
      });
    })
    ->with('detail', 'creator')
    ->orderBy('created_at', 'desc');
  }

  public function map($row): array
  {
    return [
      $row->delivery_no,
      $row->po_no,
      $row->do_no,
      $row->detail->detail_customer,
      $row->detail->detail_address,
      $row->detail->detail_city,
      $row->detail->detail_driver,
      $row->detail->detail_nopol,
      $row->detail->detail_qty.' '.$row->detail->detail_uom,
      date('d/m/Y', strtotime($row->detail->detail_sending_date)),
      $row->creator->name,
      date('d/m/Y H:i', strtotime($row->created_at)),
    ];
  }

  public function headings(): array
  {
    return [
      'Delivery_No',
      'PO',
      'DO',
      'Customer',
      'Alamat',
      'Kota',
      'Driver',
      'Nopol',
      'Qty',
      'Tgl Kirim',
      'Creator',
      'Tgl Dibuat',
    ];
  }
}
