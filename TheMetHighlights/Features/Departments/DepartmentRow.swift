import SwiftUI

struct DepartmentRow: View {
    let department: Department

    init(_ department: Department) {
        self.department = department
    }

    var body: some View {
        HStack {
            Image(systemName: "building.columns")
                .padding(.trailing, 5)
            Text(department.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 3)
        }
    }
}

#Preview {
    DepartmentRow(.mock)
}
