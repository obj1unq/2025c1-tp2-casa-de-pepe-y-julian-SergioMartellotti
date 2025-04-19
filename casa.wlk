import cosas.* 

object casaDePepeYJulian {
    var cosasCasa = []
    var property cuenta = cuentaCorriente

    method comprar(cosa){
        cuenta.extraccion(cosa.precio())
        cosasCasa.add(cosa)
    }

    method cosasCasa(){ return cosasCasa} //para testing
    method cosasCasa(lista){ cosasCasa = lista}  //para testing


    method cantidadDeCosasCompradas(){
        return cosasCasa.size()
    }

    method tieneAlgun(categoria){
        return cosasCasa.any({
                cosa => self.esCosaDeMismaCategoria(cosa, categoria)})
    }

    method vieneDeComprar(categoria){
        self.verificarQueHayaAlgo()
        return self.ultimaCosaComprada().categoria() == categoria
    }

    method verificarQueHayaAlgo(){
        if(self.cantidadDeCosasCompradas() == 0){
            self.error("No hay nada comprado aún.")
        }
    }

    method ultimaCosaComprada(){
        return cosasCasa.last()
    }
    
    method esDerrochona(){
        return self.importeTotalDeCompras() >= 9000
    }

    method importeTotalDeCompras(){
        return cosasCasa.sum({cosa => cosa.precio()})
    }

    method compraMasCara(){
        return cosasCasa.max({cosa => cosa.precio()})
    }

    method comprados(categoria){
        return cosasCasa.filter({
                cosa => self.esCosaDeMismaCategoria(cosa, categoria)})
    }

    method esCosaDeMismaCategoria(cosa, categoria){
        return cosa.categoria() == categoria
    }

    method malaEpoca(){
        return cosasCasa.all({
            cosa => self.esCosaDeMismaCategoria(cosa, comida)})
    }

    method queFaltaComprar(lista){
        return lista.filter({cosa => !self.yaSeCompro(cosa)})
    }

    method yaSeCompro(cosa){
        return cosasCasa.contains(cosa)
    }

    method faltaComida(){
        return 2 > cosasCasa.count({cosa => cosa.categoria()==comida})
    }
}


///////// Cuentas ////////////
object cuentaCorriente {
    var monto = 0                            
    method monto(){
        return monto
    }

    method ingreso(_monto){
        monto += _monto
    }

    method extraccion(_monto){
        self.validarGasto(_monto)
        monto -= _monto
    }

    method validarGasto(_monto){
        if (monto < _monto){
            self.error("No cuenta con el monto.")
        }
    }

}

object cuentaConGastos{
    var monto = 0
    var gastosCCG = 0  

    method monto(){
        return monto
    }

    method gastos(_gastosCCG){
        gastosCCG = _gastosCCG
    }

    method ingreso(_monto){
        self.validarIngreso(_monto)
        monto = monto + _monto - gastosCCG
    }

    method extraccion(_monto){
        monto -= _monto
    }

    method validarIngreso(_monto){
        if (_monto > 1000){
            self.error("No está permitido ingresar más de $1000 por vez.")
        }
    } 
}