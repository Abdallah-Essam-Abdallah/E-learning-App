import 'package:courses_app/features/payment/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddCourseToBookedCoursesUseCase {
  final PaymentRepository paymentRepository;

  const AddCourseToBookedCoursesUseCase(this.paymentRepository);

  Future<Either<Failure, Unit>> call({required String course}) async {
    return await paymentRepository.addCourseToBookedCourses(course: course);
  }
}
