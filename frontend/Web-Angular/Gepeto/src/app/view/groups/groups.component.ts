
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'

import { GroupsService } from 'src/app/services/groups-services/groups.service';

@Component({
  selector: 'app-groups',
  templateUrl: './groups.component.html',
  styleUrls: ['./groups.component.css']
})
export class GroupsComponent implements OnInit {

  groups: Array<any>;
  inputMode = false;
  formAddGroup: FormGroup;
  currentClassroom: number;
  group: any;



  constructor(private GroupService: GroupsService,
    private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showGroups();
    this.createAddGroupForm();
    this.currentClassroom = this.GroupService.currentClassroom
    // this.group = {};
  }

  showGroups() {
    this.GroupService.showGroups()
      .subscribe(data => {
        this.groups = data
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
  addGroup(frm: any) {
    this.GroupService.addGroup(frm)
      .subscribe(result =>{
        console.log(result)
        this.groups.push(result)
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

  removeGroup(groupId: number){
    this.GroupService.removeGroup(groupId)
      .subscribe(result => {
        this.groups.splice(this.groups.indexOf(groupId), 1)
        console.log('A sala foi deletada com sucesso')
      })
  }
}