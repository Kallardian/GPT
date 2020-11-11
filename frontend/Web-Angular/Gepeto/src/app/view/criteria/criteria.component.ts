import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CriteriaService } from 'src/app/services/criteria-service/criteria.service';

import { Criterion } from '../../models/criterion'

@Component({
  selector: 'app-criteria',
  templateUrl: './criteria.component.html',
  styleUrls: ['./criteria.component.css']
})
export class CriteriaComponent implements OnInit {
  criteria: Criterion[] = [];
  currentUser = localStorage.getItem('currentRa')
  inputMode = false;
  formAddCriterion: FormGroup;
  formEditCriterion: FormGroup;
  date = new Date;
  idBig = (this.date.getFullYear() - 2020) + 1
  editMode = false;

  constructor(private CriteriaService: CriteriaService,
    private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showMediumCriteria();
    this.createAddCriterionForm();
    this.createEditCriterionForm();
  }

  showMediumCriteria() {
    this.CriteriaService.showMediumCriteria()
      .subscribe(result => {
        for (let i = 0; i < result.length; i++) {
          this.criteria.push(new Criterion(result[i]["idMedium"], result[i]["idBig"], result[i]["ra"], result[i]["nameMedium"],
            result[i]["description"], result[i]["totalValue"]))
        }
      })
  }

  createAddCriterionForm() {
    this.formAddCriterion = this.fb.group({
      idBig: [
        '',
        Validators.compose([
          Validators.required
        ])
      ],
      nameMedium: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(30)
        ])
      ],
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ],
      description: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(100),
          Validators.minLength(3)
        ])
      ],
      totalValue: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(2),
          Validators.max(10)
        ])
      ]
    })
  }
  addBigCriterion() {
    this.CriteriaService.showBigCriterion()
      .subscribe(result => {
        if (result[result.length - 1]["year"] != this.date.getFullYear()) {
          this.CriteriaService.addBigCriterion()
            .subscribe(result => {
              console.log()
            })
        }
        else {
          console.log('Ok')
        }
      })
  }
  addCriteria(criterion: FormGroup) {
    this.CriteriaService.addCriterion(criterion.value)
      .subscribe(result => {
        alert('Critério "' + result["nameMedium"] + '" criado com sucesso')
        this.criteria.push(new Criterion(result["idMedium"], result["idBig"], result["ra"], result["nameMedium"], result["description"], result["totalValue"]))
        window.location.reload();
      })
  }
  removeCriterion(criterion: Criterion) {
    //checking if there's a grade with the criterion ID
    this.CriteriaService.criteriaUsed(criterion.idMedium)
      .subscribe(result => {
        if (!result) {
          this.CriteriaService.removeCriterion(criterion.idMedium)
            .subscribe(result2 => {
              this.criteria.splice(this.criteria.indexOf(criterion), 1)
              alert('Critério "' + criterion.nameMedium + '" deleto com sucesso!')
            })
        }
        else{
          alert('Este critério já recebeu nota!')
        }
      })


  }

  updateFormEdit(criteria: Criterion) { //Call usedCriterion
    this.CriteriaService.criteriaUsed(criteria.idMedium)
      .subscribe(result => {
        if (!result) {
          this.editMode = !this.editMode
          this.formEditCriterion.patchValue({
            idMedium: criteria.idMedium,
            nameMedium: criteria.nameMedium,
            description: criteria.description,
            totalValue: criteria.totalValue
          })
        }
        else {
          alert('Este critério já recebeu nota, não pode ser editado!')
        }
      })

  }
  updateCriterion(criterion: FormGroup) { //Remember to check if it already received a Grade
    this.CriteriaService.updateCriterion(criterion.value)
      .subscribe(result => {
        alert('Criterio "' + result["nameMedium"] + '" Atualizado com sucesso!')
        window.location.reload()
      })
  }
  createEditCriterionForm() {
    this.formEditCriterion = this.fb.group({
      idMedium: [
        '',
        Validators.required
      ],
      nameMedium: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(30)
        ])
      ],
      description: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(100),
          Validators.minLength(3)
        ])
      ],
      totalValue: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(2),
          Validators.max(10)
        ])
      ]
    })
  }
}
