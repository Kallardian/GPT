import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class GroupsService {

  showGroupsUrl = "http://localhost:3001/groups/"

  constructor(private http: HttpClient) { }

  showGroups(){
    return this.http.get<any[]>(`${this.showGroupsUrl}`)
  }
}
