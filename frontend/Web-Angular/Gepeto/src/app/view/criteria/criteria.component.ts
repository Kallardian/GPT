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
  date = new Date;
  idBig = (2020 - this.date.getFullYear()) + 1
  editMode = false;

  constructor(private CriteriaService: CriteriaService,
    private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showMediumCriteria();
    this.createAddCriterionForm();
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
          Validators.maxLength(300)
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
    this.CriteriaService.addBigCriterion()
      .subscribe(result => {
        console.log()
      },
        error => {
          if (error.status === 500) {
            console.log('Ok')
          }
        })
  }
  addCriteria(criterion: FormGroup) {
    this.CriteriaService.addCriterion(criterion.value)
      .subscribe(result => {
        alert('Critério "' + result["nameMedium"] + '" criado com sucesso')
        this.criteria.push(new Criterion(result["idMedium"], result["idBig"], result["ra"], result["nameMedium"], result["description"], result["totalValue"]))
        this.formAddCriterion.reset();
      })
  }
  removeCriterion(criterion: Criterion) {
    this.CriteriaService.showMediumGrades()
      .subscribe(result1 => {
        for (let i = 0; i < result1.length; i++) {
          if (!(result1[i]["idMedium"] === criterion.idMedium)) { //checking if there's a grade with the criterion ID
            this.CriteriaService.removeCriterion(criterion.idMedium)
              .subscribe(result2 => {
                this.criteria.splice(this.criteria.indexOf(criterion), 1)
                alert('Critério "' + criterion.nameMedium + '" deleto com sucesso!')
              })
          }
          else {
            alert('Este critério já recebeu notas')
          }
        }
      })
  }

  updateForm(criteria: Criterion) {
    this.inputMode = !this.inputMode
    this.editMode = !this.editMode
    this.formAddCriterion.patchValue({
      idBig: criteria.idBig,
      nameMedium: criteria.nameMedium,
      ra: criteria.ra,
      description: criteria.description,
      totalValue: criteria.totalValue
    })
  }
  updateCriterion(criterion: FormGroup){
    this.CriteriaService.updateCriterion(criterion.value)
      .subscribe(result => {
        alert('Criterio "' + result["nameMedium"] + '" Atualizado com sucesso!')
      })
  }
}
