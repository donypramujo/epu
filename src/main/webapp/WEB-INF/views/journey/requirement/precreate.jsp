<%@page import="com.kemenkes.epu.common.util.Constant"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<section class="vbox">
	<section class="scrollable padder">
		<ul class="breadcrumb no-border no-radius b-b b-light pull-in">
			<li><a href="${pageContext.request.contextPath}/"><i class="fa fa-home"></i> <spring:message code="home" /></a></li>
			<li><a href="${pageContext.request.contextPath}/journey/activity"><spring:message code="activity.list" />&nbsp;<spring:message code="year" />&nbsp;${activity.year}</a></li>
			<li><a href="${pageContext.request.contextPath}/journey/activity/${activity.code}/"><spring:message code="journey.list" /></a></li>
			<li><a href="${pageContext.request.contextPath}/journey/detail/${journey.id}/"><spring:message code="journey.detail" /></a></li>
			<li class="active"><spring:message code="requirement.journey.add" /></li>
		</ul>
		<div class="m-b-md">
			<h3 class="m-b-none">
				<spring:message code="requirement.journey.add" />
			</h3>
		</div>
		<jsp:include page="/WEB-INF/views/message.jsp" />
		<section class="panel panel-default">
			<header class="panel-heading font-bold">
				<spring:message code="journey" />
			</header>
			<div class="panel-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"><spring:message code="journey.name" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">${journey.name}</p>
							<form:errors cssClass="help-block m-b-none" path="activity.code" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"> <spring:message code="journey.location" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">${journey.location}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"> <spring:message code="journey.type" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">${journey.type.description}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"><spring:message code="journey.startDate" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">
								<fmt:formatDate value="${journey.startDate}" pattern="<%= Constant.DATE_FORMAT %>" />
							</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"><spring:message code="journey.endDate" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">
								<fmt:formatDate value="${journey.endDate}" pattern="<%= Constant.DATE_FORMAT %>" />
							</p>
						</div>
					</div>
				</form>
			</div>
		</section>
		<section class="panel panel-default">
			<header class="panel-heading font-bold">
				<spring:message code="requirement" />
			</header>
			<div class="panel-body">
				<form:form cssClass="form-horizontal" action="${pageContext.request.contextPath}/requirement/preview" modelAttribute="requirement" autocomplete="off">
					<form:hidden path="journey.id" />
					<div class="form-group">
						<label class="col-sm-2 control-label font-bold"><spring:message code="journey.account.requirement" /></label>
						<div class="col-sm-10">
							<p class="form-control-static">${journey.requirementAccount.accountNumber}&nbsp;-&nbsp;${journey.requirementAccount.name}</p>
						</div>
					</div>
					<div class="form-group">
						<form:label cssClass="col-sm-2 control-label" path="description">
							<spring:message code="requirement.journey.description" />
						</form:label>
						<div class="col-sm-6">
							<c:set var="text_requirement_journey_description">
								<spring:message code="requirement.journey.description" />
							</c:set>
							<form:input cssClass="form-control" cssErrorClass="form-control parsley-error" path="description" maxlength="100" placeholder="${text_requirement_journey_description }" />
							<form:errors cssClass="help-block m-b-none" path="description" />
						</div>
					</div>

					<div class="form-group">
						<form:label cssClass="col-sm-2 control-label" path="amount">
							<spring:message code="requirement.journey.amount" />
						</form:label>
						<div class="col-sm-6">
							<c:set var="text_requirement_journey_amount">
								<spring:message code="requirement.journey.amount" />
							</c:set>
							<form:input cssClass="form-control" cssErrorClass="form-control parsley-error" path="amount" maxlength="18" placeholder="${text_requirement_journey_amount }" />
							<form:errors cssClass="help-block m-b-none" path="amount" />
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<div class="col-sm-4 col-sm-offset-2">
							<a href="${pageContext.request.contextPath}/journey/detail/${journey.id}/" class="btn btn-default"><spring:message code="cancel" /></a>
							<form:button class="btn btn-primary">
								<spring:message code="send" />
							</form:button>
						</div>
					</div>
				</form:form>
			</div>
		</section>
		<section class="panel panel-default">
			<header class="panel-heading font-bold">
				<spring:message code="requirement.journey.list" />
			</header>
			<div class="panel-body">
				<c:set var="totals" value="0" />
				<display:table id="requirement" class="table table-striped" name="${journey.requirements }">
					<display:column titleKey="action">
						<a href="${pageContext.request.contextPath}/requirement/predelete/${requirement.id}/" class="btn btn-sm btn-danger"><i class="fa fa-minus-square"></i> <spring:message code="delete" /></a>
					</display:column>
					<display:column titleKey="requirement.journey.description">${requirement.description }</display:column>
					<display:column titleKey="requirement.journey.amount">
						<fmt:formatNumber value="${requirement.amount}" currencySymbol="Rp." pattern="� #,##0.00;� -#,##0.00" />
						<c:set var="totals" value="${totals + requirement.amount}" />
					</display:column>
					<display:footer>
						<tr>
							<td colspan="2" class="font-bold"><spring:message code="total" /></td>
							<td><fmt:formatNumber value="${totals}" currencySymbol="Rp." pattern="� #,##0.00;� -#,##0.00" /></td>
						</tr>
					</display:footer>
				</display:table>
			</div>
		</section>
	</section>
</section>
<script type="text/javascript">
	$(document).ready(function() {
		select_nav("#nav_journey_list");
	});
</script>
