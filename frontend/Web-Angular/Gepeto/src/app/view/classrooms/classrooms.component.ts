import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ClassroomsService } from 'src/app/services/classrooms-services/classrooms.service';
import { Classroom } from 'src/models/classroom.model';

@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css']
})
export class ClassroomsComponent implements OnInit {

 // public classrooms: Classroom[] = [];
  classrooms: Array<any>;
  public title: String = 'Salas';
  public givenNumberOfClassrooms: Number;
  formNumberClassrooms: FormGroup;


  constructor(private fb: FormBuilder, private ClassroomService: ClassroomsService) {
  }

  ngOnInit(): void {
    this.createNumberClassroomForm();
    this.showClassrooms();
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

  // addClassroom(numberOfClassrooms: Number) { //aqui viria uma maneira de chamar a SP_INSERT_CLASSROOM e retornar as classes
  //   let lastClassroom: number; 
  //   lastClassroom = this.classrooms[this.classrooms.length - 1]?.id
  //   console.log(lastClassroom)

  //   if (numberOfClassrooms > lastClassroom || lastClassroom == undefined) {
  //     if(lastClassroom == undefined){
  //       lastClassroom = 0
  //     }
  //     for (let i = lastClassroom; i < numberOfClassrooms; i++) {
  //       this.classrooms.push(new Classroom(i + 1, 'INF3' + String.fromCharCode(65 + i) + 'M', '2020'))
  //     }
  //   }
  //   else{
      
  //   }
  

  // }
  removeClassroom(classroomRemoved: Classroom) { //aqui é a SP_DELETE_CLASSROOM
    const index = this.classrooms.indexOf(classroomRemoved)
    this.classrooms.splice(index, 1)
  }

  showClassrooms(){
    this.ClassroomService.showClassrooms()
      .subscribe(data => this.classrooms = data);
  }

}
