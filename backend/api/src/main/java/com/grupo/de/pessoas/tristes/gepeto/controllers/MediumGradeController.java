package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.dtos.MediumGrade;
import com.grupo.de.pessoas.tristes.gepeto.repositories.MediumGradeRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/medium-grades")
public class MediumGradeController {

    private MediumGradeRepository mediumGradeRepository = new MediumGradeRepository();

    //Function
    @GetMapping("/biggest-attempt/{id_group}")
    public ResponseEntity getBiggestAttempt(@PathVariable() Long id_group) {

        int attempt = mediumGradeRepository.getBiggestAttempt(id_group);

        return ResponseEntity.ok().body(attempt);
    }

    //GET
    @GetMapping
    public ResponseEntity getMediumGrades() {

        List<MediumGrade> mediumGrades = mediumGradeRepository.showMediumGrade();

        return ResponseEntity.ok().body(mediumGrades);
    }

    @GetMapping("/group/{group_id}")
    public ResponseEntity getMediumGradesByGroupId(@PathVariable() Long group_id) {

        List<MediumGrade> mediumGrades = mediumGradeRepository.showMediumGradeByGroupId(group_id);

        return ResponseEntity.ok().body(mediumGrades);
    }

    @GetMapping("/{medium_grade_id}")
    public ResponseEntity getMediumGradeById(@PathVariable() Long medium_grade_id) {

        MediumGrade mediumGrade = new MediumGrade();
        mediumGrade.setIdMediumGrade(medium_grade_id);

        mediumGrade = mediumGradeRepository.getMediumGradeById(mediumGrade);

        return ResponseEntity.ok().body(mediumGrade);
    }

    //POST
    @PostMapping
    public ResponseEntity<?> postMediumGrade(@RequestBody MediumGrade jsonMediumGrade) throws URISyntaxException {

        MediumGrade mediumGrade = new MediumGrade();
        mediumGrade.setIdMedium(jsonMediumGrade.getIdMedium());
        mediumGrade.setRa(jsonMediumGrade.getRa());
        mediumGrade.setIdGroup(jsonMediumGrade.getIdGroup());
        mediumGrade.setGrade(jsonMediumGrade.getGrade());
        mediumGrade.setAttempt(jsonMediumGrade.getAttempt());

        mediumGradeRepository.postMediumGrade(mediumGrade);

        URI location = new URI("/medium-grades/" + mediumGrade.getRa());
        return ResponseEntity.created(location).body(mediumGrade);
    }
}