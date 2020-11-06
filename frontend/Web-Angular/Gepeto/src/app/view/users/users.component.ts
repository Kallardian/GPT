import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'
import { Component, OnInit } from '@angular/core';

import { UsersService } from './../../services/users-services/users.service'
import { User } from './../../models/user'
@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users: User[];
  formUser: FormGroup;
  addMode = false;
  userRA: JSON
  editUser = false;


  constructor(private UsersService: UsersService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showUsers();
    this.createUserForm();
    this.users = [];
  }
  showUsers() {
    this.UsersService.showUsers()
      .subscribe(data => {
        
        for(let i = 0; i < data.length; i++){
          this.users.push(new User(data[i][0], data[i][1], data[i][2], data[i][3]))
        }
      });
  }
  removeUser(user) {
    this.UsersService.deleteUser(user[0])
      .subscribe(result => {
        this.users.splice(this.users.indexOf(user), 1)
        window.alert('Usuário Deletado com Sucesso')
      },
        erro => {
          window.alert('Este usuário não pode ser deletado')
        })
  }
  createUserForm() {
    this.formUser = this.fb.group({
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ],
      fullName: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])
      ],
      password: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])
      ],
      access: [
        '',
        Validators.compose([
          Validators.required,
        ])
      ]
    });
  }
  saveUser(user: FormGroup) {
    this.UsersService.addUser(user.value)
      .subscribe(result => {
        console.log(result)
        // this.users.push(result)
        this.formUser.reset()
        // this.userRA = JSON.parse(JSON.stringify(user.value))
        // console.log(this.userRA[0])
      }
      )
  }

  changeToAddMode() {
    this.addMode = !this.addMode
  }

  editUserOpen(user) {
    this.changeToAddMode()
    this.updateForm(user)
    this.editUser = true
  }
  updateForm(user){
    this.formUser.patchValue({
      ra: user[0],
      fullName: user[1],
      password: 123456,
      access: user[3]
    })
  }

  sendEditUser(user: FormGroup){
    this.UsersService.editUser(user.value)
    .subscribe(result => {
      console.log(result)
      // this.users.push(result)
    })
  }
}
