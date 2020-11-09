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
  formEditGroup: FormGroup;
  currentClassroom = localStorage.getItem('currentClassroom')
  group: any;
  currentUser = localStorage.getItem('currentRa')
  editMode = false;

  
 
  constructor(private GroupService: GroupsService,
              private fb: FormBuilder,
              private LoginService: LoginService) { }

  ngOnInit(): void {
    this.showGroups();
    this.createAddGroupForm();
    this.createEditGroupForm();
  }

  showGroups() {
    this.GroupService.showGroups()
      .subscribe(result => {
        console.log(result)
        for(let i = 0; i < result.length; i++){
          this.groups.push(new Group(result[i].idGroup, result[i].groupTheme, 
                                     result[i].description, result[i].idClassroom, result[i].ra))
        }
      });
  }

  createAddGroupForm() {
    this.formAddGroup = this.fb.group({
      groupTheme: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(50)
        ])
      ],
      description: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
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
    alert(frm.value["idClassroom"])
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
  createEditGroupForm() {
    this.formEditGroup = this.fb.group({
      idGroup:[
        '',
        Validators.compose([
          Validators.required
        ])
      ],
      idClassroom: [
        '',
        
      ],
      description: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(300)
        ])
      ],
      groupTheme: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(50)
        ])
      ]
    })
  }
  updateEditForm(group: Group){
    this.formEditGroup.patchValue({
      idGroup: group.id,
      idClassroom: this.currentClassroom,
      description: group.description,
      groupTheme: group.groupTheme

    })
  }

  editGroup(formEditGroup: FormGroup){
    
  }
}