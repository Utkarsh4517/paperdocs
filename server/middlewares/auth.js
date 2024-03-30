const jwt = require("jsonwebtoken")

const auth = async (req, res, next) => {
    try{
        const token = req.header("auth-token");
        if(!token) return res.status(401).json({msg: "Authentication token is required. Access Denied"});

        const verifiedToken = jwt.verify();
        if(!verifiedToken) return res.status(401).json({msg: "Token Verificatoin Failed. Access Denied"});

        req.user = verified.id;
        req.token = token;
        next();
    } catch(e){
        res.status(500).json({ error : e.message});
    }
}

module.exports = auth;