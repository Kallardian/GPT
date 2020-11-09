import { Classroom } from '../../models/classroom';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { ClassroomsService } from 'src/app/services/classrooms-services/classrooms.service';



@Component({
  selector: 'app-classrooms',
  templateUrl: './classrooms.component.html',
  styleUrls: ['./classrooms.component.css'],
  providers: [ClassroomsService]
})
export class ClassroomsComponent implements OnInit {
  public title: String = 'Salas';

  classrooms: Classroom[] = [];
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
          Validators.maxLength(2),
          Validators.max(12),
          Validators.pattern('[0-9 ]*')
        ])
      ],
    });
  }

  addClassroom(givenNumberOfClassrooms: number) { //aqui viria uma maneira de chamar a SP_INSERT_CLASSROOM e retornar as classes
    this.ClassroomService.addClassroms(givenNumberOfClassrooms)
      .subscribe(
        result => {
          console.log(result)
          window.location.reload();
        }
      )
  }
  removeClassroom(classroomRemoved: Classroom) { //aqui é a SP_DELETE_CLASSROOM
    // const idClassroomToBeRemovedString = JSON.stringify(new Number(classroomRemoved[0]))
    // const idClassroomToBeRemovedNumber: number = parseInt(idClassroomToBeRemovedString)
    const Groups = this.GroupService.showGroups(classroomRemoved["idClassroom"]);
    Groups.subscribe(data => {
      if (data.length != 0) {
        alert('Esta sala não pode ser deletada')
      }
      else {
        this.ClassroomService.removeClassroom(classroomRemoved["idClassroom"])
          .subscribe(
            result => {
              this.GroupService.showGroups
              alert('Sala "' + classroomRemoved["nameClassroom"] + '" Excluida com Sucesso')
              const index = this.classrooms.indexOf(classroomRemoved)
              this.classrooms.splice(index, 1)
              this.givenNumberOfClassrooms -= 1;
            })
      }
    })
  }

  showClassrooms() {
    this.ClassroomService.showClassrooms()
      .subscribe(data => {
        this.classrooms = data;
        this.givenNumberOfClassrooms = data.length
      });
  }
  // changeGroupsUrlService(classroomId: number) {
  //   // this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl.replace(/\d+/g, '')
  //   // this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl + classroomId
  //   this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl.substring(0,17)
  //   this.GroupService.changeCurrentClassroom(classroomId);
  // }
  clearLocal() {
    localStorage.clear();
  }
  changeCurrentClassroom(classroomId: number) {
    localStorage.removeItem('currentClassroom')
    const classroomIdString = classroomId.toString()
    localStorage.setItem('currentClassroom', classroomIdString)
  }

}
