package com.grupo.de.pessoas.tristes.gepeto.dtos;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_CLASSROOM")
@Data
public class Classroom {

    @Id
    @Column(name = "ID_CLASSROOM")
    private Long id_classroom;
    @Column(name = "NAME_CLASSROOM")
    private String name;
    @Column(name = "YEAR")
    private int year;
}
