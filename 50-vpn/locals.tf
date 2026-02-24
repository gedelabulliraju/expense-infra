locals {
    resource_name = "${var.project_name}-${var.environment}-vpn"
    vpn_sg_id = data.aws_ssm_parameter.vpn_sg_id.value
    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
}