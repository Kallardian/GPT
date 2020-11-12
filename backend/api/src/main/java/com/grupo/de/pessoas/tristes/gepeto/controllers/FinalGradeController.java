package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.FinalGrade;
import com.grupo.de.pessoas.tristes.gepeto.repositories.FinalGradeRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/final-grades")
public class FinalGradeController {

    private FinalGradeRepository finalGradeRepository = new FinalGradeRepository();

    //GET
    @GetMapping("/{group_id}")
    public ResponseEntity getFinalGradesById(@PathVariable() Long group_id) {

        List<FinalGrade> finalGradeList = finalGradeRepository.showFinalGrades(group_id);

        return ResponseEntity.ok().body(finalGradeList);
    }
}
