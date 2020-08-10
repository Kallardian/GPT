package com.grupo.de.pessoas.tristes.gepeto.controllers;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/classrooms/{id_classrooms}/groups/{id_groups}/students")
public class StudentController {

    @GetMapping
    public String showStudents(@PathVariable() int id_classrooms, @PathVariable int id_groups) {
        return "all students from classroom " + id_classrooms + " at group " + id_groups + ".";
    }

    @GetMapping("/{rm}")
    public String findStudent(@PathVariable() int id_student) {
        return "student";
    }

    @PostMapping
    public String createStudent() {
        return "student created";
    }

    @PutMapping("/{rm}")
    public String updateStudent(@PathVariable() int id_student) {
        return "update student";
    }

    @DeleteMapping("/{rm}")
    public String deleteStudent(@PathVariable() int id_student) {
        return "student deleted";
    }
}
