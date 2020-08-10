package com.grupo.de.pessoas.tristes.gepeto.dtos;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "TB_STUDENT")
@Data
public class Student {

    @Id
    @Column(name = "RM")
    private String rm;
    @Column(name = "FULL_NAME")
    private String fullName;
    @Column(name = "GRADUATE_TCC")
    private boolean graduate_tcc;
}
