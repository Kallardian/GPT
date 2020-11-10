package com.grupo.de.pessoas.tristes.gepeto.controllers;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.dtos.MediumCriterion;
import com.grupo.de.pessoas.tristes.gepeto.repositories.MediumCriterionRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/medium-criteria")
public class MediumCriterionController {

    private MediumCriterionRepository mediumCriterionRepository = new MediumCriterionRepository();

    //Function
    @GetMapping("/used/{criterion_id}")
    public ResponseEntity isCriterionUsed(@PathVariable() Long criterion_id) {

        int isUsed = mediumCriterionRepository.isCriterionUsed(criterion_id);

        if (isUsed == 0) {
            return ResponseEntity.ok().body(false);
        } else return ResponseEntity.ok().body(true);
    }

    //GET
    @GetMapping
    public ResponseEntity getMediumCriteria() {

        List<MediumCriterion> mediumCriteria = mediumCriterionRepository.showMediumCriteria();

        return ResponseEntity.ok().body(mediumCriteria);
    }

    @GetMapping("/{id_medium}")
    public ResponseEntity getMediumCriterionById(@PathVariable() Long id_medium) {

        MediumCriterion mediumCriterion = new MediumCriterion();
        mediumCriterion.setIdMedium(id_medium);

        mediumCriterion = mediumCriterionRepository.getMediumCriterionById(mediumCriterion);

        return ResponseEntity.ok().body(mediumCriterion);
    }

    //POST
    @PostMapping
    public ResponseEntity<?> postMediumCriterion(@RequestBody MediumCriterion jsonMediumCriterion) throws URISyntaxException {

        MediumCriterion mediumCriterion = new MediumCriterion();
        mediumCriterion.setIdBig(jsonMediumCriterion.getIdBig());
        mediumCriterion.setNameMedium(jsonMediumCriterion.getNameMedium());
        mediumCriterion.setRa(jsonMediumCriterion.getRa());
        mediumCriterion.setDescription(jsonMediumCriterion.getDescription());
        mediumCriterion.setTotalValue(jsonMediumCriterion.getTotalValue());

        mediumCriterionRepository.postMediumCriterion(mediumCriterion);

        URI location = new URI("/medium-criteria/" + mediumCriterion.getRa());
        return ResponseEntity.created(location).body(mediumCriterion);
    }

    //PUT
    @PutMapping
    public ResponseEntity updateMediumCriterion(@RequestBody MediumCriterion jsonMediumCriterion) {

        MediumCriterion mediumCriterion = new MediumCriterion();
        mediumCriterion.setIdMedium(jsonMediumCriterion.getIdMedium());
        mediumCriterion.setNameMedium(jsonMediumCriterion.getNameMedium());
        mediumCriterion.setDescription(jsonMediumCriterion.getDescription());
        mediumCriterion.setTotalValue(jsonMediumCriterion.getTotalValue());

        mediumCriterionRepository.updateMediumCriterion(mediumCriterion);

        return ResponseEntity.ok().body(mediumCriterion);
    }

    //DELETE
    @DeleteMapping("/{id_medium}")
    public ResponseEntity deleteMediumCriterion(@PathVariable() Long id_medium) {

        MediumCriterion mediumCriterion = new MediumCriterion();
        mediumCriterion.setIdMedium(id_medium);

        mediumCriterionRepository.deleteMediumCriterion(mediumCriterion);

        return ResponseEntity.noContent().build();
    }
}
