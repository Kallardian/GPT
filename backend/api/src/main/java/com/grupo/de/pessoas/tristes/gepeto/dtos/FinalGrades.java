package com.grupo.de.pessoas.tristes.gepeto.dtos;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_FINAL_GRADES")
@Data
public class FinalGrades {

    @Id
    @Column(name = "ID_FINAL_GRADE")
    private int idSmallGrade;
    @Column(name = "ID_MEDIUM")
    private String idMedium;
    @Column(name = "ID_GROUP")
    private int idGroup;
    @Column(name = "GRADE")
    private double grade;
}
