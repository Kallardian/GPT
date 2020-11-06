import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class UsersService {
  readonly apiURL = "/api/users/"
  


  constructor(private http: HttpClient) {
   }

  showUsers(){
    return this.http.get<any[]>(`${this.apiURL}`)
  }
  deleteUser(userId: number){
    return this.http.delete<any[]>(`${this.apiURL}` + userId)
  }
  addUser(user: any){
    return this.http.post(this.apiURL, user)
  }
  editUser(user){
    return this.http.put(this.apiURL, user)
  }
}
