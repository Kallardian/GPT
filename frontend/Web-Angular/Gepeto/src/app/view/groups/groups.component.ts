import { LoginService } from '../../services/login-service/login.service';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'

import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { Group } from 'src/app/models/group';

@Component({
  selector: 'app-groups',
  templateUrl: './groups.component.html',
  styleUrls: ['./groups.component.css']
})
export class GroupsComponent implements OnInit {

  groups: Group[] = [];
  inputMode = false;
  formAddGroup: FormGroup;
  currentClassroom: number;
  group: any;
  currentUser: number;

  
 
  constructor(private GroupService: GroupsService,
              private fb: FormBuilder,
              private LoginService: LoginService) { }

  ngOnInit(): void {
    this.showGroups();
    this.createAddGroupForm();
    this.currentClassroom = this.GroupService.currentClassroom
    // this.groups = []
  }

  showGroups() {
    this.GroupService.showGroups()
      .subscribe(result => {
        console.log(result)
        for(let i = 0; i < result.length; i++){
          this.groups.push(new Group(result[i][0], result[i][2], result[i][3], result[i][1], result[i][4]))
        }
      });
  }

  createAddGroupForm() {
    this.formAddGroup = this.fb.group({
      groupTheme: [
        '',
        Validators.compose([
          Validators.required,
          Validators.maxLength(50)
        ])
      ],
      description: [
        '',
        Validators.compose([
          Validators.maxLength(300)
        ])
      ],
      idClassroom: [
        '',
        
      ],
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ]
    })
  }
  addGroup(frm: FormGroup) {
    this.GroupService.addGroup(frm.value)
      .subscribe(result =>{
        console.log(result["idGroup"])
        this.groups.push(new Group(result["idGroup"], result["groupTheme"], result["description"], result["idClassroom"], result["ra"]))
        window.alert('Grupo Adicionado com Sucesso')
        this.formAddGroup.reset()
      });
  }
  changeToInputMode(){
    this.inputMode = !this.inputMode
  }
  changeShowGroupsUrl(classroomId){
    this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl.replace(/\d+/g, '')
    this.GroupService.showGroupsUrl = this.GroupService.showGroupsUrl + classroomId
    this.changeToInputMode()
  }

  removeGroup(group: Group){
    this.GroupService.removeGroup(group.id)
      .subscribe(result => {
        this.groups.splice(this.groups.indexOf(group), 1)
        window.alert('O grupo foi deletado com sucesso')
      })
  }
}