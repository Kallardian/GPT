import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  loginUserUrl = '/api/users/login'
  currentUser: number;

  constructor(private http: HttpClient,
              private GroupService: GroupsService) { }

  loginUser(user: any){
    return this.http.post(this.loginUserUrl, user);
  }
  sendCurrentUser(){
    this.GroupService.currentUserGroupService = this.currentUser
  }
}
