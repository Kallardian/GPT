import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Classroom } from 'src/models/classroom.model';

@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css']
})
export class ClassroomsComponent implements OnInit{ 
  public classrooms: Classroom[] = [];
  public title: String = 'Salas'
  formNumberClassrooms: FormGroup;

  constructor(private fb: FormBuilder) {
    this.classrooms.push(new Classroom(1, 'INF3AM', '2020'));
    this.classrooms.push(new Classroom(2, 'INF3BM', '2020'));
    this.classrooms.push(new Classroom(3, 'INF3CM', '2020'));
  }

  ngOnInit(): void {
    this.createNumberClassroomForm()
  }

  createNumberClassroomForm() {
    this.formNumberClassrooms = this.fb.group({
      numberClassroom: [
        '',
        Validators.compose([
          Validators.required
        ])
      ],
    });
  }

}
