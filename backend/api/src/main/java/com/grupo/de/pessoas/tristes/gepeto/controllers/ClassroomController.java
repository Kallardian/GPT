package com.grupo.de.pessoas.tristes.gepeto.controllers;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/classrooms")
public class ClassroomController {

    @GetMapping
    public String showClassrooms() {
        return "all classrooms";
    }

//    @GetMapping("/{id_classroom}")
//    public String findClassroom(@PathVariable() int id_classroom) {
//        return "classroom";
//    }
//
//    @PostMapping
//    public String createClassroom() {
//        return "classroom created";
//    }
//
//    @PutMapping("/{id_classroom}")
//    public String updateClassroom(@PathVariable() int id_classroom) {
//        return "update classroom";
//    }
//
//    @DeleteMapping("/{id_classroom}")
//    public String deleteClassroom(@PathVariable() int id_classroom) {
//        return "classroom deleted";
//    }
}
