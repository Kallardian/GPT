import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class UsersService {

  showUsersUrl = "http://localhost:3001/users/"

  constructor(private http: HttpClient) { }

  showUsers(){
    return this.http.get<any[]>(`${this.showUsersUrl}`)
  }
}
