package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.repositories.ClassroomRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/classrooms")
public class ClassroomController {

    private ClassroomRepository classroomRepository = new ClassroomRepository();

    //Function
    @GetMapping("/amount")
    public ResponseEntity amountOfClassrooms() {

        Classroom classroom = new Classroom();

        int amount = classroomRepository.amountOfClassrooms();

        return ResponseEntity.ok().body(amount);
    }

    //GET
    @GetMapping("/show")
    public ResponseEntity getClassrooms() {

        List<Classroom> classrooms = classroomRepository.showClassrooms();

        return ResponseEntity.ok().body(classrooms);
    }

    @GetMapping("/{classroom_id}")
    public ResponseEntity getClassroomById(@PathVariable() Long classroom_id) {

        Classroom classroom = new Classroom();
        classroom.setIdClassroom(classroom_id);

        classroom = classroomRepository.getClassroomById(classroom);

        return ResponseEntity.ok().body(classroom);
    }

    //POST
    @PostMapping("/post/{amount}")
    public ResponseEntity<?> postClassroom(@PathVariable() int amount) {

        classroomRepository.postClassrooms(amount);

        return ResponseEntity.ok().build();
    }

    //DELETE
    @DeleteMapping("/delete/{classroom_id}")
    public ResponseEntity deleteClassroom(@PathVariable() Long classroom_id) {

        Classroom classroom = new Classroom();
        classroom.setIdClassroom(classroom_id);

        classroomRepository.deleteClassroom(classroom);

        return ResponseEntity.noContent().build();
    }
}