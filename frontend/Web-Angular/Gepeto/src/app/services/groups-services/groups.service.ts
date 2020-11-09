import { GroupsComponent } from './../../view/groups/groups.component';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class GroupsService {

  showGroupsUrl = "/api/groups/show/";
  GroupsUrl = "/api/groups/";
  mediumGradesUrl = "/api/medium-grades/";
  currentClassroom: number;
  currentUserGroupService: any;


  constructor(private http: HttpClient) { }

  showGroups(idClasrrom: number = 0){
    if(idClasrrom === 0){
      return this.http.get<any[]>(`${this.showGroupsUrl}` + localStorage.getItem('currentClassroom'))
    }
    else{
      return this.http.get<any[]>(`${this.showGroupsUrl}` + idClasrrom)
    }

  }

  // changeCurrentClassroom(classroomId: number){
  //   this.currentClassroom = classroomId;
  // }
  // changeCurrentUser(userId: number){
  //   this.currentUserGroupService = userId
  // }

  addGroup(group: any){
    return this.http.post(this.GroupsUrl, group);
  }

  removeGroup(groupId){
    this.GroupsUrl = this.GroupsUrl.replace(/\d+/g, '');
    this.GroupsUrl = this.GroupsUrl + groupId.toString();
    return this.http.delete(`${this.GroupsUrl}`)
  }
  editGroup(group: any){
    return this.http.put(this.GroupsUrl, group)
  }

  showMediumGrades(){
    return this.http.get<any>(`${this.mediumGradesUrl}`)
  }

} 
