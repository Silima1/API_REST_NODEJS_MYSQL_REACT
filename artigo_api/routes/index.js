var express = require('express');
var router = express.Router();
var { db } = require("../db/db");

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/artigo', async function (req, res, next) {
  const artigos = await db.getArtigos();
  res.json(artigos)
  // res.render('artigo', { artigos: artigos });
});

router.get('/artigo/:id', async function (req, res, next) {
  const artigo = await db.getArtigo(req.params.id);
  res.json(artigo)
  // res.render('artigo', { artigos: artigos });
});

router.post('/artigo', async function (req, res, next) {
  if (!req.body.titulo) {
    res.status(400).send("titulo é obrigatorio")
    return
  }
  if (!req.body.documento) {
    res.status(400).send("documento é obrigatorio")
    return
  }
  if (!req.body.autorCorrespondente) {
    res.status(400).send("autorCorrespondente é obrigatorio")
    return
  }
  if (!req.body.autores || !req.body.autores.length) {
    res.status(400).send("autores é obrigatorio")
    return
  }
  if (!req.body.autores.includes(req.body.autorCorrespondente)) {
    res.status(400).send("autorCorrespondente tem de estar nos autores")
    return
  }

  const idArtigo = await db.newArtigo(req.body);
  res.status(200).send(idArtigo)
  // res.render('artigo', { artigos: artigos });
});

router.put('/artigo/:id', async function (req, res, next) {
  if (!req.body.titulo) {
    res.status(400).send("titulo é obrigatorio")
    return
  }
  if (!req.body.documento) {
    res.status(400).send("documento é obrigatorio")
    return
  }
  if (!req.body.autorCorrespondente) {
    res.status(400).send("autorCorrespondente é obrigatorio")
    return
  }
  if (!req.body.autores || !req.body.autores.length) {
    res.status(400).send("autores é obrigatorio")
    return
  }
  if (!req.body.autores.includes(req.body.autorCorrespondente)) {
    res.status(400).send("autorCorrespondente tem de estar nos autores")
    return
  }

  const idArtigo = await db.updateArtigo(req.params.id, req.body);
  res.status(200).send(idArtigo)
  // res.render('artigo', { artigos: artigos });
});

router.delete('/artigo/:id', async function (req, res, next) {
  await db.deleteArtigo(req.params.id);
  res.status(204).send()
  // res.render('artigo', { artigos: artigos });
});

router.get('/autor', async function (req, res, next) {
  const autor = await db.getAutores();
  res.json(autor)
  // res.render('artigo', { artigos: artigos });
});

module.exports = router;
