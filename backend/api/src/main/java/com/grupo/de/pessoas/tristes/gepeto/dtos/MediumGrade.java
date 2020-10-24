package com.grupo.de.pessoas.tristes.gepeto.dtos;

import lombok.Data;

import javax.persistence.*;
//
//@NamedStoredProcedureQuery(
//        name = "",
//        procedureName = "",
//        parameters = {
//
//        }
//)

@Entity
@Table(name = "TB_MEDIUM_GRADE")
@Data
public class MediumGrade {

    @Id
    @Column(name = "ID_MEDIUM_GRADE")
    private Long idMediumGrade;
    @Column(name = "RA")
    private String ra;
    @Column(name = "ID_MEDIUM")
    private Long idMedium;
    @Column(name = "ID_GROUP")
    private Long idGroup;
    @Column(name = "GRADE")
    private double grade;
    @Column(name = "ATTEMPT")
    private int attempt;
}
