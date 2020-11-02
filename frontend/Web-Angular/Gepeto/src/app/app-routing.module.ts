import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './view/login/login.component'
import { ClassroomsComponent } from './view/classrooms/classrooms.component'
import { GroupsComponent } from './view/groups/groups.component'

const routes: Routes = [
  { path: 'login', component: LoginComponent},
  { path: 'classrooms', component: ClassroomsComponent },
  { path: 'groups', component: GroupsComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
