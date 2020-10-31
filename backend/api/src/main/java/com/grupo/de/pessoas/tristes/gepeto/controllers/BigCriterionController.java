package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.BigCriterion;
import com.grupo.de.pessoas.tristes.gepeto.repositories.BigCriterionRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/big-criteria")
public class BigCriterionController {

    private BigCriterionRepository bigCriterionRepository = new BigCriterionRepository();

    //GET
    @GetMapping
    public ResponseEntity getBigCriteria() {

        List<BigCriterion> bigCriteria = bigCriterionRepository.showBigCriteria();

        return ResponseEntity.ok().body(bigCriteria);
    }

    @GetMapping("/{big_criterion_id}")
    public ResponseEntity getBigCriterionById(@PathVariable() Long big_criterion_id) {

        BigCriterion bigCriterion = new BigCriterion();
        bigCriterion.setIdBig(big_criterion_id);

        bigCriterion = bigCriterionRepository.getBigCriterionById(bigCriterion);

        return ResponseEntity.ok().body(bigCriterion);
    }

    //POST
    @PostMapping
    public ResponseEntity<?> postBigCriterion() {

        bigCriterionRepository.postBigCriterion();

        return ResponseEntity.noContent().build();
    }
}