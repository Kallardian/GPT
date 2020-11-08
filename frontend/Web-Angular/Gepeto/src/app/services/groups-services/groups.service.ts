import { GroupsComponent } from './../../view/groups/groups.component';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class GroupsService {

  showGroupsUrl = "/api/groups/show/"
  postGroupsUrl = "/api/groups/"
  deleteGroupsUrl = "/api/groups/"
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
    return this.http.post(this.postGroupsUrl, group);
  }

  removeGroup(groupId){
    this.deleteGroupsUrl = this.deleteGroupsUrl.replace(/\d+/g, '');
    this.deleteGroupsUrl = this.deleteGroupsUrl + groupId.toString();
    return this.http.delete(`${this.deleteGroupsUrl}`)
  }
} 
