import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class _AppRoutePaths {
  static const initial = '/';
  static const login = '/login';
  static const home = '/home';

  static const operations = '/home/operations';

  static const gateEntry = '/home/gateentry';
  static const newGateEntry = '/home/gateentry/newGateEntry';
  static const newGateEntryPreview = '/home/gateentry/newGateEntry/preview';
  static const gateExit = '/home/gateexit';
  static const newGateExit = '/home/gateexit/newGateExit';
  static const newGateExitPreview = '/home/gateexit/newGateExit/preview';
  static const tcList = '/home/operations/tcList';
  static const jobCardItems = '/home/operations/tcList/jobCardItems';
  static const scanMachine = '/home/operations/tcList/scanMachine';
  static const workStation = '/home/operations/tcList/scanMachine/workStation';

  static const incidentRegister = '/home/incidentRegister';
  static const newIncidentReg = '/home/incidentRegister/newIncReg';
  static const inviteVisitor = '/home/inviteVisitor';
  static const newInviteVisitor = '/home/inviteVisitor/newInviteVisitor';
  static const visitorInOut = '/home/visitorInOut';
  static const newVisitorInOut = '/home/visitorInOut/newVisitorInOut';
  static const createVisit = '/home/createVisit';
  static const newCreateVisit = '/home/createVisit/newCreateVisit';
  static const outWardGatePass = '/home/outWardGatePass';
  static const newOutWardGatePass = '/home/outWardGatePass/newOutWardGatePass';
  static const inWardGatePass = '/home/inWardGatePass';
  static const newInWardGatePass = '/home/inWardGatePass/newInWardGatePass';
  static const emptyVehicle = '/home/emptyVehicle';
  static const newEmptyVehicle = '/home/emptyVehicle/newEmptyVehicle';
  static const account = '/account';
  static const dashboard = '/dashBoard';
}

enum AppRoute {
  initial(_AppRoutePaths.initial),
  login(_AppRoutePaths.login),
  home(_AppRoutePaths.home),

  gateEntry(_AppRoutePaths.gateEntry),
  newGateEntry(_AppRoutePaths.newGateEntry),
  newGateEntryPreview(_AppRoutePaths.newGateEntryPreview),
  gateExit(_AppRoutePaths.gateExit),
  newGateExit(_AppRoutePaths.newGateExit),
  newGateExitPreview(_AppRoutePaths.newGateExitPreview),

  operations(_AppRoutePaths.operations),
  tcList(_AppRoutePaths.tcList),
  jobCardItems(_AppRoutePaths.jobCardItems),
  scanMachine(_AppRoutePaths.scanMachine),
  workStation(_AppRoutePaths.workStation),
  incidentRegister(_AppRoutePaths.incidentRegister),
  newIncidentReg(_AppRoutePaths.newIncidentReg),
  inviteVisitor(_AppRoutePaths.inviteVisitor),
  newInviteVisitor(_AppRoutePaths.newInviteVisitor),
  visitorInOut(_AppRoutePaths.visitorInOut),
  newVisitorInOut(_AppRoutePaths.newVisitorInOut),
  createVisit(_AppRoutePaths.createVisit),
  newCreateVisit(_AppRoutePaths.newCreateVisit),
  outWardGatePass(_AppRoutePaths.outWardGatePass),
  newOutWardGatePass(_AppRoutePaths.newOutWardGatePass),
  inWardGatePass(_AppRoutePaths.inWardGatePass),
  newInWardGatePass(_AppRoutePaths.newInWardGatePass),
  emptyVehicle(_AppRoutePaths.emptyVehicle),
  newEmptyVehicle(_AppRoutePaths.newEmptyVehicle),
  account(_AppRoutePaths.account),
  dashboard(_AppRoutePaths.dashboard);

  const AppRoute(this.path);
  final String path;
}

extension AppRouteNavigation on AppRoute {
  void go(BuildContext context, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void goNamed(BuildContext context, {Object? extra}) {
    context.goNamed(path, extra: extra);
  }

  Future<T?> push<T>(BuildContext context, {Object? extra}) async {
    return await context.push(path, extra: extra);
  }
}
