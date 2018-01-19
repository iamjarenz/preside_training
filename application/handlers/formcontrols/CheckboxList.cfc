component {

	property name="presideObjectService" inject="presideObjectService";

	public string function website( event, rc, prc, args={} ) {

		var objectName = args.object ?: "";
		var objectResult = presideObjectService.selectData(
			selectFields = [
				  "category.id"
				, "category.label"
			]
			, objectName = objectName
			, orderBy    = "category.label ASC"

		);

		args.values = valueList(objectResult.id);
		args.labels = valueList(objectResult.label);


		return renderView( view="formcontrols/checkboxList/website", args=args );
	}
}