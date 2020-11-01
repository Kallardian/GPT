import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Classroom } from 'src/models/classroom.model';

@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css']
})
export class ClassroomsComponent implements OnInit {
  public classrooms: Classroom[] = [];
  public title: String = 'Salas';
  public givenNumberOfClassrooms: Number;
  formNumberClassrooms: FormGroup;


  constructor(private fb: FormBuilder) {
  }

  ngOnInit(): void {
    this.createNumberClassroomForm()
  }

  createNumberClassroomForm() {
    this.formNumberClassrooms = this.fb.group({
      numberClassroom: [
        '',
        Validators.compose([
          Validators.required,
          Validators.min(1),
          Validators.maxLength(2)
        ])
      ],
    });
  }

  addClassroom(numberOfClassrooms: Number) { //aqui viria uma maneira de chamar a SP_INSERT_CLASSROOM
    for (let i = 0; i < numberOfClassrooms; i++) {
      this.classrooms.push(new Classroom(i + 1, 'INF3' + String.fromCharCode(65 + i) + 'M', '2020'))
    }    
  }
  removeClassroom(classroomRemoved: Classroom){ //aqui é a SP_DELETE_CLASSROOM
    const index = this.classrooms.indexOf(classroomRemoved)
    this.classrooms.splice(index, 1)
  }

}
