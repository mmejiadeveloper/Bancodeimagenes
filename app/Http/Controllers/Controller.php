<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    protected $transferredArray = [];
    protected $debugAsyncRequests = true;
    protected $errorDetailedInfo = '';

    public function __construct()
    {
        $this->middleware('auth');
        $this->postData = isset($_POST['data']) ? $this->axiosDataToAssocArray(json_decode($_POST['data'])) : [];
    }

    protected function axiosDataToAssocArray($asyncData): array
    {
        try {
            foreach ($asyncData as $key => $value) {
                $this->createAndFillAssocArray($key, $value);
            }
        } catch (\Throwable $th) {
            dd(
                [
                    "File" => $th->getFile(),
                    "Line" => $th->getLine(),
                    "Message" => $th->getMessage(),
                ]
            );
        }

        return $this->transferredArray;
    }

    private function createAndFillAssocArray($key, $value)
    {
        $this->transferredArray[$key] = $value;
        $this->validateObjectDataType($value, $key);
    }

    private function validateObjectDataType($value, $key)
    {
        $type = gettype($value);
        if ($type == "object") {
            $this->fillAssocArrayChildItems($value, $key);
        }
    }

    private function fillAssocArrayChildItems($value, $key)
    {
        $temporalTransferredArray = [];
        foreach ($value as $skey => $svalue) {
            $temporalTransferredArray[$skey] = $svalue;
        }
        // dd($);
        $this->transferredArray[$key] = $temporalTransferredArray;
    }

    private function normalizeFilesArray($files = [])
    {

        $normalized_array = [];

        foreach ($files as $index => $file) {

            if (!is_array($file['name'])) {
                $normalized_array[$index][] = $file;
                continue;
            }

            foreach ($file['name'] as $idx => $name) {
                $normalized_array[$index][$idx] = [
                    'name' => $name,
                    'type' => $file['type'][$idx],
                    'tmp_name' => $file['tmp_name'][$idx],
                    'error' => $file['error'][$idx],
                    'size' => $file['size'][$idx]
                ];
            }
        }

        return $normalized_array;
    }

    protected function errorReporting($th)
    {
        $this->errorDetailedInfo = "error found @ line: " . $th->getLine() . ". Error: " . $th->getMessage();
        if ($this->debugAsyncRequests) {
            dd($this->errorDetailedInfo);
        } else {
            $response = [
                "type" => 3,
                "message" => "Ha ocurrido un fallo en el sistema, si el problema persiste por favor comuniquese con los administradores.",
                "details" => $this->errorDetailedInfo,
            ];
        }
        return $response;
    }
}
