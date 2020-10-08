package com.grupo.de.pessoas.tristes.gepeto.dtos;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_SMALL_GRADES")
@Data
public class SmallGrades {

    @Id
    @Column(name = "ID_SMALL_GRADE")
    private int idSmallGrade;
    @Column(name = "RA")
    private String ra;
    @Column(name = "ID_SMALL")
    private int idSmall;
    @Column(name = "ID_GROUP")
    private int idGroup;
    @Column(name = "GRADE")
    private double grade;
}
