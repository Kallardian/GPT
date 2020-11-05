import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { ClassroomsService } from 'src/app/services/classrooms-services/classrooms.service';
import { Classroom } from 'src/models/classroom.model';


@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css'],
  providers: [ClassroomsService]
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

  addClassroom(givenNumberOfClassrooms: number) { //aqui viria uma maneira de chamar a SP_INSERT_CLASSROOM e retornar as classes
    this.ClassroomService.addClassroms(givenNumberOfClassrooms)
      .subscribe(
        result => {
          console.log(result)
          // this.classrooms.push(result)
        }
      )
  }
  removeClassroom(classroomRemoved: Classroom) { //aqui é a SP_DELETE_CLASSROOM
    const idClassroomToBeRemovedString = JSON.stringify(new Number(classroomRemoved[0]))
    const idClassroomToBeRemovedNumber: number = parseInt(idClassroomToBeRemovedString)
    this.ClassroomService.removeClassroom(idClassroomToBeRemovedNumber)
      .subscribe(
        result => {
          console.log('Sala Excluida com Sucesso')
          const index = this.classrooms.indexOf(classroomRemoved)
          this.classrooms.splice(index, 1)
        },
        error => {
          if (error.status == 500) {
            console.log('Essa sala não pode ser removida, pois já contem grupos.')
          }
        }
      )
  }

  showClassrooms() {
    this.ClassroomService.showClassrooms()
      .subscribe(data => this.classrooms = data);
  }
  changeGroupsUrlService(classroomId: number) {
    this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl.replace(/\d+/g, '')
    this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl + classroomId
    this.GroupService.changeCurrentClassroom(classroomId);
  }

}
