import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class GroupsService {

  showGroupsUrl = "/api/groups/show/"
  postGroupsUrl = "/api/groups/"
  currentClassroom: number;

  constructor(private http: HttpClient) { }

  showGroups(){
    return this.http.get<any[]>(`${this.showGroupsUrl}`)
  }
  changeCurrentClassroom(classroomId: number){
    this.currentClassroom = classroomId;
  }
  addGroup(group: any){
    return this.http.post(this.postGroupsUrl, group);
  }
}
