import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { ClassroomsService } from 'src/app/services/classrooms-services/classrooms.service';
import { Classroom } from 'src/models/classroom.model';


@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css']
})
export class ClassroomsComponent implements OnInit {
  public title: String = 'Salas';

  classrooms: Array<any>;
  givenNumberOfClassrooms: number;
  formNumberClassrooms: FormGroup;

  constructor(private fb: FormBuilder, 
              private ClassroomService: ClassroomsService,
              private GroupService: GroupsService) { }

    

  ngOnInit(): void {
    this.createNumberClassroomForm();
    this.showClassrooms();
    this.givenNumberOfClassrooms = 0;
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

  addClassroom(amountOfClassrooms: number) { //aqui viria uma maneira de chamar a SP_INSERT_CLASSROOM e retornar as classes
    this.ClassroomService.addClassroms(amountOfClassrooms)
    .subscribe()
  }
  removeClassroom(classroomRemoved: Classroom) { //aqui é a SP_DELETE_CLASSROOM
    const index = this.classrooms.indexOf(classroomRemoved)
    this.classrooms.splice(index, 1)
  }

  showClassrooms(){
    this.ClassroomService.showClassrooms()
      .subscribe(data => this.classrooms = data);
  }
  changeGroupsUrlService(classroomId: number){
    this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl + 'classroom/' + classroomId
  }


}
