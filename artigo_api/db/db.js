var mysql = require('mysql');
var util = require("util")

class db {
    static async execute(query, params) {
        var connection = mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: '',
            database: 'test'
        });
        connection.connect();
        const asyncQuery = util.promisify(connection.query).bind(connection)

        const resultado = await asyncQuery(query, params)

        connection.end();
        return resultado
    }

    static async getAutores() {
        return db.execute("select * from autor")
    }

    static async getArtigos() {
        const artigos = await db.execute("select * from artigo")
        for (const el of artigos) {
            el.autores = await db.execute("select * from artigo_tem_autor where artigo = ?", [el.id])
            el.autores.forEach((el2, i) => {
                el.autores[i] = el2.autor
            })
            el.documento = (await db.execute("select * from documento where id = ?", [el.documento]))[0].nome
        }
        return artigos
    }

    static async updateArtigo(idArtigo, artigo) {
        const documento = await db.execute("select * from documento where nome = ?", [artigo.documento])
        let idDocumento = 0
        if (!documento.length) {
            const result = await db.execute("insert into documento (nome, caminho) values (?, ?)", [artigo.documento, `C://documento/${artigo.documento}`])
            idDocumento = result.insertId
        }
        else {
            idDocumento = documento[0].id
        }

        await db.execute("update artigo set titulo = ?, autor_correspondente = ?, documento = ? where id = ?", [artigo.titulo, artigo.autorCorrespondente, idDocumento, Number(idArtigo)])

        await db.execute("delete from artigo_tem_autor where artigo = ?", [idArtigo])
        for (const el of artigo.autores) {
            await db.execute("insert into artigo_tem_autor (artigo, autor) values (?, ?)", [idArtigo, el])
        }
        return idArtigo
    }

    static async deleteArtigo(idArtigo){
        await db.execute("delete from artigo_tem_palavra_chave where artigo = ?", [idArtigo])
        await db.execute("delete from artigo_tem_autor where artigo = ?", [idArtigo])
        await db.execute("delete from artigo where id = ?", [idArtigo])
    }

    static async newArtigo(artigo) {
        const documento = await db.execute("select * from documento where nome = ?", [artigo.documento])
        let idDocumento = 0
        if (!documento.length) {
            const result = await db.execute("insert into documento (nome, caminho) values (?, ?)", [artigo.documento, `C://documento/${artigo.documento}`])
            idDocumento = result.insertId
        }
        else {
            idDocumento = documento[0].id
        }

        const result = await db.execute("insert into artigo (titulo, autor_correspondente, documento) values (?, ?, ?)", [artigo.titulo, artigo.autorCorrespondente, idDocumento])
        let idArtigo = result.insertId

        for (const el of artigo.autores) {
            await db.execute("insert into artigo_tem_autor (artigo, autor) values (?, ?)", [idArtigo, el])
        }
        return idArtigo
    }

    static async getArtigo(id) {
        const el = await db.execute("select * from artigo where id = ?", [id])
        const artigo = el.length ? el[0] : null
        artigo.autores = await db.execute("select * from artigo_tem_autor where artigo = ?", [artigo.id])
        artigo.autores.forEach((el2, i) => {
            artigo.autores[i] = el2.autor
        })
        artigo.documento = (await db.execute("select * from documento where id = ?", [artigo.documento]))[0].nome
        return artigo
    }
}

module.exports = {
    db
}