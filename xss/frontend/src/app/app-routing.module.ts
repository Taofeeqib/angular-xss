import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AddMoviesComponent } from './user/add-movies/add-movies.component';
import { EditComponent } from './user/edit/edit.component';
import { MoviesComponent } from './user/movies/movies.component';
import { UserComponent } from './user/user.component';

const routes: Routes = [
  {
    path: '', 
    component:HomeComponent,
  },
  {
    path: 'user',
    component: UserComponent,
    children:[
      {path: '', component: MoviesComponent},
      {path: 'edit', component: EditComponent},
      {path: 'addmovie', component: AddMoviesComponent}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
