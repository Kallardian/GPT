import { GradesService } from './../../services/grades-service/grades.service';
import { Component, OnInit } from '@angular/core';
import { Grades } from 'src/app/models/grades';

@Component({
  selector: 'app-grades',
  templateUrl: './grades.component.html',
  styleUrls: ['./grades.component.css']
})
export class GradesComponent implements OnInit {
  grades: Grades[] = [];
  currentGroup = localStorage.getItem("idGroup")
  finalGrade: number = 0;

  constructor(private GradesService: GradesService) { }

  ngOnInit(): void {
    this.showGradesGroup()
    this.showFinalGrade()

  }

  showGradesGroup() {
    this.GradesService.showGrades(this.currentGroup)
      .subscribe(result => {
        for (let i = 0; i < result.length; i++) {
          this.grades.push(new Grades(result[i]["nameCriterion"], result[i]["grade"]))
        }
      })
  }
  showFinalGrade() {
    this.GradesService.showGrades(this.currentGroup)
      .subscribe(result => {
        for (let i = 0; i < result.length; i++) {
          this.finalGrade += result[i]["grade"]

          this.finalGrade = parseFloat(this.finalGrade.toFixed(2))
        }
      })
  }
}
