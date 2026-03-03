<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Student;

class StudentController extends Controller
{
    public function index()
{
    return response()->json(Student::all());
}

    public function allstudent() {
        $allstudent = Student::all();

        return view('all_student' , compact('allstudent'));
    }

}
