component {

	property name="presideObjectService" inject="presideObjectService";

	public string function website( event, rc, prc, args={} ) {

		var objectName = args.object ?: "";
		if( !isEmptyString(objectName) ) {
			var objectResult = presideObjectService.selectData(
				selectFields = [
					  objectName&".id"
					, objectName&".label"
				]
				, objectName = objectName
				, orderBy    = objectName&".label ASC"

			);

			args.values = valueList(objectResult.id);
			args.labels = valueArray(objectResult.label);
		}


		return renderView( view="formcontrols/checkboxList/website", args=args );
	}
}